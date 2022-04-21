Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EEDC433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 02:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96A184052F;
	Thu, 21 Apr 2022 02:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MvGtcxLce1rN; Thu, 21 Apr 2022 02:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E607440129;
	Thu, 21 Apr 2022 02:14:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFC9FC0033;
	Thu, 21 Apr 2022 02:14:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36623C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 02:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2345F41A56
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 02:14:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5kXydoQVd7t
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 02:14:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA96D419B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 02:14:52 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 10FD8B82158;
 Thu, 21 Apr 2022 02:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD65C385A1;
 Thu, 21 Apr 2022 02:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650507288;
 bh=NiQktVTI2fOvmytyuJRHJ/KoFh9/1WdmpPTFSrV+IbU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=JdmlsUhtwNUtzNA1fWG8HUt2E1htr120E5x5i+Ycomzew8CHxMVKv2gaRjFMj4NDb
 CLf0dgheRjewNtiLAHY8xTh9DeLEoXiMjzG+jjzG5JxmxdzlwdXxzqyzOCmRFf+7zb
 QO3t/Jx982gd8WkK8T5GsRJNC9NaQmhjxmb+iEZBoqpytcSu6xF5J7OJ+Dk0FCKTms
 Jf0wMwwe1OUc5kcZU/x7hVmrGUEN+tHo83wvuZziKCOuwHwvZl50VCipXEqcwEWxUs
 q+n2pOZZkK+QzaEkHHOCIdCzxDLp9xZDn7yNpp+phBPrDrxn4f5Wqi+0Z+kS3mppxZ
 9HzmJR0DCJwtw==
Date: Wed, 20 Apr 2022 21:14:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] PCI: Clean up pci_scan_slot()
Message-ID: <20220421021446.GA1356365@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220419102803.3430139-2-schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
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

Hi Niklas,

I'm sure this makes good sense, but I need a little more hand-holding.
Sorry this is long and rambling.

On Tue, Apr 19, 2022 at 12:28:00PM +0200, Niklas Schnelle wrote:
> While determining the next PCI function is factored out of
> pci_scan_slot() into next_fn() the former still handles the first
> function as a special case duplicating the code from the scan loop and
> splitting the condition that the first function exits from it being
> multifunction which is tested in next_fn().
> 
> Furthermore the non ARI branch of next_fn() mixes the case that
> multifunction devices may have non-contiguous function ranges and dev
> may thus be NULL with the multifunction requirement. It also signals
> that no further functions need to be scanned by returning 0 which is
> a valid function number.
> 
> Improve upon this by moving all conditions for having to scan for more
> functions into next_fn() and make them obvious and commented.
> 
> By changing next_fn() to return -ENODEV instead of 0 when there is no
> next function we can then handle the initial function inside the loop
> and deduplicate the shared handling.
> 
> No functional change is intended.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/probe.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..389aa1f9cb2c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2579,33 +2579,35 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>  }
>  EXPORT_SYMBOL(pci_scan_single_device);
>  
> -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> -			    unsigned int fn)
> +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>  {
>  	int pos;
>  	u16 cap = 0;
>  	unsigned int next_fn;
>  
> -	if (pci_ari_enabled(bus)) {
> -		if (!dev)
> -			return 0;
> +	if (dev && pci_ari_enabled(bus)) {

I think this would be easier to verify if we kept the explicit error
return, e.g.,

  if (pci_ari_enabled(bus)) {
    if (!dev)
      return -ENODEV;
    pos = pci_find_ext_capability(...);

Otherwise we have to sort through the !dev cases below.  I guess
-ENODEV would come from either the "!fn && !dev" case or the "fn > 6"
case, but it's not obvious to me that those are equivalent to the
previous code.

>  		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
>  		if (!pos)
> -			return 0;
> +			return -ENODEV;
>  
>  		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
>  		next_fn = PCI_ARI_CAP_NFN(cap);
>  		if (next_fn <= fn)
> -			return 0;	/* protect against malformed list */
> +			return -ENODEV;	/* protect against malformed list */
>  
>  		return next_fn;
>  	}
>  
> -	/* dev may be NULL for non-contiguous multifunction devices */
> -	if (!dev || dev->multifunction)
> -		return (fn + 1) % 8;
> -
> -	return 0;
> +	/* only multifunction devices may have more functions */
> +	if (dev && !dev->multifunction)
> +		return -ENODEV;

I don't understand why the "!dev || dev->multifunction" test needs to
change.  Isn't that valid even in the hypervisor case?  IIUC, you want
to return success in some cases that currently return failure, so this
case that was already success should be fine as it was.

Is this because "(fn + 1) % 8" may be zero, which previously
terminated the loop, but now it doesn't because "fn == 0" is the
*first* execution of the loop?

If so, I wonder if we could avoid that case by adding:

  if (fn >= 7)
    return -ENODEV;

at the very beginning.  Maybe that would allow a more trivial patch
that just changed the error return from 0 to -ENODEV, i.e., leaving
all the logic in next_fn() unchanged?

I'm wondering if this could end up like:

    if (fn >= 7)
      return -ENODEV;

    if (pci_ari_enabled(bus)) {
      if (!dev)
	return -ENODEV;
      ...
      return next_fn;
    }

    if (!dev || dev->multifunction)
      return (fn + 1) % 8;

 +  if (hypervisor_isolated_pci_functions())
 +    return (fn + 1) % 8;

    return -ENODEV;

(The hypervisor part being added in a subsequent patch, and I'm not
sure exactly what logic you need there -- the point being that it's
just an additional success case.)

The "% 8" seems possibly superfluous then, since previously that
caused a zero return that terminated the loop.  If we're using -ENODEV
to terminate the loop, we probably don't care about the mod 8.

> +	/*
> +	 * A function 0 is required but multifunction devices may
> +	 * be non-contiguous so dev can be NULL otherwise.

I understood the original "dev may be NULL ..." comment, but I can't
quite parse this.  "dev can be NULL" for non-zero functions?  That's
basically what it said before, but it's not clear what "otherwise"
refers to.

> +	 */
> +	if (!fn && !dev)
> +		return -ENODEV;

This part isn't obvious to me yet, partly because of the "!fn && !dev"
construction.  The negatives make it hard to parse.

Since "fn" isn't a boolean or a pointer, I think "fn == 0" is easier
to read than "!fn".  I would test "dev" first since it logically
precedes "fn".

IIUC !dev means we haven't found a function at this device number yet.
So this:

  if (!dev && fn == 0)
    return -ENODEV;

means we called pci_scan_single_device(bus, devfn + 0) the first time
through the loop, and it didn't find a device so it returned NULL.

> +	return (fn <= 6) ? fn + 1 : -ENODEV;
>  }
>  
>  static int only_one_child(struct pci_bus *bus)
> @@ -2643,24 +2645,19 @@ static int only_one_child(struct pci_bus *bus)
>   */
>  int pci_scan_slot(struct pci_bus *bus, int devfn)
>  {
> -	unsigned int fn, nr = 0;
> -	struct pci_dev *dev;
> +	int fn, nr = 0;
> +	struct pci_dev *dev = NULL;
>  
>  	if (only_one_child(bus) && (devfn > 0))
>  		return 0; /* Already scanned the entire slot */
>  
> -	dev = pci_scan_single_device(bus, devfn);
> -	if (!dev)
> -		return 0;
> -	if (!pci_dev_is_added(dev))
> -		nr++;
> -
> -	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
> +	for (fn = 0; fn >= 0; fn = next_fn(bus, dev, fn)) {
>  		dev = pci_scan_single_device(bus, devfn + fn);

"devfn + fn" (in the existing, unchanged code) is a little bit weird.
In almost all cases, devfn is the result of "PCI_DEVFN(slot, 0)", so
we could make the interface:

  pci_scan_slot(struct pci_bus *bus, int dev)

where "dev" is 0-31.

The only exceptions are a couple hotplug drivers where the fn probably
is or should be 0, too, but I haven't verified that.

But this would be scope creep, so possibly something we could consider
in the future, but not for this series.

>  		if (dev) {
>  			if (!pci_dev_is_added(dev))
>  				nr++;
> -			dev->multifunction = 1;
> +			if (nr > 1)
> +				dev->multifunction = 1;
>  		}
>  	}
>  
> -- 
> 2.32.0
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
