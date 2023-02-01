Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453B1C636D7
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 17:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C545E4097A;
	Wed,  1 Feb 2023 17:46:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C545E4097A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T264EBIr7b70; Wed,  1 Feb 2023 17:46:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ABD0940248;
	Wed,  1 Feb 2023 17:46:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABD0940248
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ABB6C0032;
	Wed,  1 Feb 2023 17:46:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C331BC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 17:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86945408FB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 17:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86945408FB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8qkJ0SnJvCIy
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 17:46:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33FD6408DF
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33FD6408DF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 17:46:41 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 b10-20020a4a9fca000000b004e6f734c6b4so2012392oom.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Feb 2023 09:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5ieMICCVHRQ7377at7SykjLSFOGHCDvEdg4MaUlrEI=;
 b=3x3eS5RRNdeQqqsByIxqtAH+8UyksS3FSAIkS8T2GdA3Rv29UPABt7PtZPan/O5NB6
 bVY6IkfcjN0ygXynsAofSMGShcM18zanv6ScEwibxY+t9Qn+2MDoRcxXN/U1Mkdw1SuM
 nJWg/JHjC1mHfoRJ5hT+9wTxwiIYChIbRGRO9tqZ5dpjacLcsaTwKqz5VH1OR5cWEWis
 4Jg8SnyP2miotBENw2UP/G/e+LnzGA0/OoCOAwsUF6le9ZiwWngPSK9vomCi2coJBMjD
 HG9ruNwJdcct1X4+x6DdT/SU1QmuxAI9hb/PkZukq4r1fC1v3CD7LtIzAkWoTgZrKfzM
 Dzcg==
X-Gm-Message-State: AO0yUKXd6UqY+2LsVVsUdjVxQxjBgTvbCzjX0F3yyDwRP1IG2JNkh2cG
 RowgEokUTF9n5xJEndOM8Q==
X-Google-Smtp-Source: AK7set+96DYcWpNNDjOz3WVmZYP3qKBM36nDwTflxgqE4s8Zv/Y+Hek1aSYQygLj/tx4aDfNUN4/8A==
X-Received: by 2002:a05:6820:131:b0:517:3cd0:5505 with SMTP id
 i17-20020a056820013100b005173cd05505mr1635601ood.3.1675273599932; 
 Wed, 01 Feb 2023 09:46:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 j4-20020a4a92c4000000b004a3d98b2ccdsm7630636ooh.42.2023.02.01.09.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Feb 2023 09:46:39 -0800 (PST)
Received: (nullmailer pid 4050504 invoked by uid 1000);
 Wed, 01 Feb 2023 17:46:38 -0000
Date: Wed, 1 Feb 2023 11:46:38 -0600
From: Rob Herring <robh@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 6/6] Driver: VMBus: Add device tree support
Message-ID: <20230201174638.GA3872117-robh@kernel.org>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
 <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Cc: devicetree@vger.kernel.org, wei.liu@kernel.org, ssengar@microsoft.com,
 mikelley@microsoft.com, linux-hyperv@vger.kernel.org, haiyangz@microsoft.com,
 daniel.lezcano@linaro.org, decui@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, krzysztof.kozlowski+dt@linaro.org,
 tglx@linutronix.de
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Feb 01, 2023 at 08:51:33AM -0800, Saurabh Singh Sengar wrote:
> On Tue, Jan 31, 2023 at 02:12:53PM -0600, Rob Herring wrote:
> > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > <ssengar@linux.microsoft.com> wrote:
> > >
> > > Update the driver to support device tree boot as well along with ACPI.
> > > At present the device tree parsing only provides the mmio region info
> > > and is not the exact copy of ACPI parsing. This is sufficient to cater
> > > all the current device tree usecases for VMBus.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  drivers/hv/vmbus_drv.c | 75 ++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 73 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 49030e756b9f..1741f1348f9f 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -2152,7 +2152,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
> > >         device_unregister(&device_obj->device);
> > >  }
> > >
> > > -
> > > +#ifdef CONFIG_ACPI
> > >  /*
> > >   * VMBUS is an acpi enumerated device. Get the information we
> > >   * need from DSDT.
> > > @@ -2262,6 +2262,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
> > >
> > >         return AE_OK;
> > >  }
> > > +#endif
> > >
> > >  static void vmbus_mmio_remove(void)
> > >  {
> > > @@ -2282,7 +2283,7 @@ static void vmbus_mmio_remove(void)
> > >         }
> > >  }
> > >
> > > -static void vmbus_reserve_fb(void)
> > > +static void __maybe_unused vmbus_reserve_fb(void)
> > >  {
> > >         resource_size_t start = 0, size;
> > >         struct pci_dev *pdev;
> > > @@ -2442,6 +2443,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
> > >  }
> > >  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> > >
> > > +#ifdef CONFIG_ACPI
> > 
> > It's better to put C 'if (!IS_ENABLED(CONFIG_ACPI)' code in the
> 
> I wanted to have separate function for ACPI and device tree flow, which
> can be easily maintained with #ifdef. Please let me know if its fine.

Yes, you can have separate functions:

static int vmbus_acpi_add(struct platform_device *pdev)
{
	if (!IS_ENABLED(CONFIG_ACPI))
		return -ENODEV;

	...
}

The compiler will throw away the function in the end if CONFIG_ACPI is 
not enabled.

That is easier for us to maintain because it reduces the combinations to 
build.

> 
> > 
> > >  static int vmbus_acpi_add(struct platform_device *pdev)
> > >  {
> > >         acpi_status result;
> > > @@ -2496,10 +2498,68 @@ static int vmbus_acpi_add(struct platform_device *pdev)
> > >                 vmbus_mmio_remove();
> > >         return ret_val;
> > >  }
> > > +#else
> > > +
> > > +static int vmbus_device_add(struct platform_device *pdev)
> > > +{
> > > +       struct resource **cur_res = &hyperv_mmio;
> > > +       struct device_node *np;
> > > +       u32 *ranges, len;
> > > +       u64 start;
> > > +       int nr_ranges, child_cells = 2, cur_cell = 0, ret = 0;
> > > +
> > > +       hv_dev = pdev;
> > > +       np = pdev->dev.of_node;
> > > +
> > > +       nr_ranges = device_property_count_u32(&pdev->dev, "ranges");
> > 
> > Parsing ranges yourself is a bad sign. It's a standard property and we
> > have functions which handle it. If those don't work, then something is
> > wrong with your DT or they need to be fixed/expanded.
> 
> I find all the  standard functions which parse "ranges" property are doing
> much more then I need. Our requirement is to only pass the mmio memory range
> and size, I couldn't find any standard API doing this.

You can't just change how standard properties work to suit your needs.

We shouldn't even be having this discussion because we have tools to 
check all this now. dtc does some and dtschema does a lot more.

> I see some of the drivers are using these APIs to parse ranges property hence
> I follwed those examples. I will be happy to improve it if I get any better
> alternative.

You can always find bad examples to follow...

> > > +       if (nr_ranges < 0)
> > > +               return nr_ranges;
> > > +       ranges = kcalloc(nr_ranges, sizeof(u32), GFP_KERNEL);
> > > +       if (!ranges)
> > > +               return -ENOMEM;
> > > +
> > > +       if (device_property_read_u32_array(&pdev->dev, "ranges", ranges, nr_ranges)) {
> > > +               ret =  -EINVAL;
> > > +               goto free_ranges;
> > > +       }
> > > +
> > > +       while (cur_cell < nr_ranges) {
> > > +               struct resource *res;
> > > +
> > > +               /* The first u64 in the ranges description isn't used currently. */
> > > +               cur_cell = cur_cell + child_cells;
> > > +               start = ranges[cur_cell++];
> > > +               start = (start << 32) | ranges[cur_cell++];
> > > +               len = ranges[cur_cell++];
> > 
> > To expand my last point, the format of ranges is <child_addr
> > parent_addr length>. That's not what your 'ranges' has. You've also
> > just ignored '#address-cells' and '#size-cells'.
> 
> Got it. However I need to check if there is any standard API which can
> give me these values, otherwise I may have to parse these as well :(

for_each_of_range()

That is not how linux works. When the core code doesn't do what you 
want, you adapt it to your needs. You don't work around it. Read 
this[1].

Rob

[1] https://lwn.net/Articles/443531/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
