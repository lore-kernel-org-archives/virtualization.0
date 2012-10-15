From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: potential integer overflow in xenbus_file_write()
Date: Mon, 15 Oct 2012 11:25:57 +0100
Message-ID: <1350296757.18058.21.camel__3945.9029133015$1350297396$gmane$org@zakaz.uk.xensource.com>
References: <20120913160032.GA29082@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120913160032.GA29082@elgon.mountain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: xen-devel <xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-09-13 at 19:00 +0300, Dan Carpenter wrote:
> Hi,

Thanks Dan. I'm not sure anyone from Xen-land really monitors
virtualization@. Adding xen-devel and Konrad.

> 
> I was reading some code and had a question in xenbus_file_write()
> 
> drivers/xen/xenbus/xenbus_dev_frontend.c
>    461          if ((len + u->len) > sizeof(u->u.buffer)) {
>                      ^^^^^^^^^^^^
> Can this addition overflow?

len is a size_t and u->len is an unsigned int, so I expect so.

>   Should the test be something like:
> 
> 	if (len > sizeof(u->u.buffer) || len + u->len > sizeof(u->u.buffer)) {

I think that would do it.

Ian.

>    462                  /* On error, dump existing buffer */
>    463                  u->len = 0;
>    464                  rc = -EINVAL;
>    465                  goto out;
>    466          }
>    467  
>    468          ret = copy_from_user(u->u.buffer + u->len, ubuf, len);
>    469  
> 
> regards,
> dan carpenter
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
