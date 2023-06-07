// IMPORT FROM PACKAGES
const express=require("express");
const mongoose=require("mongoose");

// IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/products");
const userRouter = require("./routes/user");

// INIT
const PORT= process.env.PORT || 3000;
const app=express();
const DB="mongodb+srv://Neeraj:Neeraj%402002@cluster0.tadzi0i.mongodb.net/?retryWrites=true&w=majority";

// MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// CONNECTIONS

mongoose.connect(DB).then(()=>{
    console.log("connection successful");
}).catch((e)=>{
    console.log(e);
});








app.listen(PORT,()=>{
    console.log(`connect at port ${PORT}`);
});