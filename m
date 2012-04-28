From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [Xen-devel] [PATCH] drivers/video/xen-fbfront.c: add missing
	cleanup code
Date: Sat, 28 Apr 2012 23:47:42 +0000
Message-ID: <4F9C819E.4030205__40079.2306209498$1336411816$gmane$org@gmx.de>
References: <1335088660-13219-1-git-send-email-Julia.Lawall@lip6.fr>
	<20120426214222.GA11289@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120426214222.GA11289@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Julia Lawall <Julia.Lawall@lip6.fr>, linux-fbdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Konrad,

On 04/26/2012 09:42 PM, Konrad Rzeszutek Wilk wrote:
> On Sun, Apr 22, 2012 at 11:57:40AM +0200, Julia Lawall wrote:
>> From: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> The operations in the subsequent error-handling code appear to be also
>> useful here.
> 
> How about doing it this way?

Looks good to me.

> Florian, are you OK me carrying this patch in my tree for Linus or would
> you prefer to do it?

Yes, I'm okay with you carrying this patch. Feel free to add
Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>


Best regards,

Florian Tobias Schandinat

> 
> commit a833fb9973b47cb30d1086e73f20b62a425bcd85
> Author: Julia Lawall <Julia.Lawall@lip6.fr>
> Date:   Sun Apr 22 11:57:40 2012 +0200
> 
>     drivers/video/xen-fbfront.c: add missing cleanup code
>     
>     The operations in the subsequent error-handling code appear to be also
>     useful here.
>     
>     Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>     [v1: Collapse some of the error handling functions]
>     Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
> index cb4529c..aa42160 100644
> --- a/drivers/video/xen-fbfront.c
> +++ b/drivers/video/xen-fbfront.c
> @@ -458,26 +458,31 @@ static int __devinit xenfb_probe(struct xenbus_device *dev,
>  	xenfb_init_shared_page(info, fb_info);
>  
>  	ret = xenfb_connect_backend(dev, info);
> -	if (ret < 0)
> -		goto error;
> +	if (ret < 0) {
> +		xenbus_dev_fatal(dev, ret, "xenfb_connect_backend");
> +		goto error_fb;
> +	}
>  
>  	ret = register_framebuffer(fb_info);
>  	if (ret) {
> -		fb_deferred_io_cleanup(fb_info);
> -		fb_dealloc_cmap(&fb_info->cmap);
> -		framebuffer_release(fb_info);
>  		xenbus_dev_fatal(dev, ret, "register_framebuffer");
> -		goto error;
> +		goto error_fb;
>  	}
>  	info->fb_info = fb_info;
>  
>  	xenfb_make_preferred_console();
>  	return 0;
>  
> - error_nomem:
> -	ret = -ENOMEM;
> -	xenbus_dev_fatal(dev, ret, "allocating device memory");
> - error:
> +error_fb:
> +	fb_deferred_io_cleanup(fb_info);
> +	fb_dealloc_cmap(&fb_info->cmap);
> +	framebuffer_release(fb_info);
> +error_nomem:
> +	if (!ret) {
> +		ret = -ENOMEM;
> +		xenbus_dev_fatal(dev, ret, "allocating device memory");
> +	}
> +error:
>  	xenfb_remove(dev);
>  	return ret;
>  }
> 
> 
> 
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> ---
>> Not tested.
>>
>>  drivers/video/xen-fbfront.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
>> index cb4529c..b0bd59c 100644
>> --- a/drivers/video/xen-fbfront.c
>> +++ b/drivers/video/xen-fbfront.c
>> @@ -458,8 +458,13 @@ static int __devinit xenfb_probe(struct xenbus_device *dev,
>>  	xenfb_init_shared_page(info, fb_info);
>>  
>>  	ret = xenfb_connect_backend(dev, info);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>> +		fb_deferred_io_cleanup(fb_info);
>> +		fb_dealloc_cmap(&fb_info->cmap);
>> +		framebuffer_release(fb_info);
>> +		xenbus_dev_fatal(dev, ret, "xenfb_connect_backend");
>>  		goto error;
>> +	}
>>  
>>  	ret = register_framebuffer(fb_info);
>>  	if (ret) {
>>
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xen.org
>> http://lists.xen.org/xen-devel
> 
