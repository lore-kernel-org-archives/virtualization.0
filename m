Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516832;
	b=Q6SGlwdjKXKH7KQd1qpn4BtgNtItfc/uEnLJyfBA0T6x3OrA9WzgKffzrUQVlVtEuUkd
	 EpvNqx/bqfpIg0ZRptzcCw32dRa32EZQIzoDZJUa+bhv8DbZb8lbAK+/HmeyTovHg+HE3
	 K8/EwnYalQweE/L+p/N432QryBkzL8ThiKlkNMbItpJPdK9+TCqrf1wvxxA6zXuV+QMjW
	 mkzUFGwwegfGYsoUYZnvB84Jmt07j62JIPHtoH1yLifUL5KX3j4lJK/3a9AP+3BttqEW2
	 /3ozEXU1a1clcOOAK08NY8GHANqcqEUwUEEj2RGJ5G8DYVqVQ7xSOrZI/tsIfsk4NLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516832;
	h=Received:Received:Received:X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:
	 Feedback-ID:Received:X-Mailer:MIME-Version:Date:From:To:Cc:Message-Id:
	 In-Reply-To:References:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=5kyu4r+trzHwvD7p12rdlnbQGjA0zLCDieMzvIJkdu0=;
	b=pkpcWre4hFk2/+R4WolC/ejcXdlAdQI8oELgypkMl8QnqdBXBwTvRHBbvWwm5gzOhpo2
	 wM5R9bn1/MNy+utqUeQbeThgoITCf9D8w9V4hiNvqRXpEqoikmnRmZ9jmbry/IdLK4IXk
	 gRW27YR4jfjWuNRZOIMNtKRiZOwnoQ8e0FdYjoW5qbFPcdKREZg4Izi3F54aQvh3imopL
	 psOrylqsV1/vqvJvueDj2LDciAMJYAsNB10eD4S5yLaFmnzJalO0o59T1M+H+fQzaBDPv
	 qLYlEp+NPLDzUVygCOzSuJeBKr/jsegCr/vLEUnBibmeYaWbexS5XcVDMGwH7JNKJBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF2606A31E
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476FA1F000CA;
	Tue, 20 Oct 2026 17:20:31 +0000 (UTC)
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfauth.stl.internal (Postfix) with ESMTP id 9461D780043;
	Tue, 20 Oct 2026 13:20:10 -0400 (EDT)
Received: from stl-imap-11 ([10.204.2.102])
  by stl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 13:20:10 -0400
X-ME-Sender: <xms:yqLXakIQlpx2zqtcVasZwEsyrdYJlP_GEq4__MrOKmffMcgyAJ7btw>
    <xme:yqLXau8L55JVe0GXMaZ4e7gFfL7ShasEFEyX7rrTYp9v3DI-jDodcBOWLDQzCQpGf
    ypN4Tp26-BKv6IqmuWutBpBpzU75Ozz29LMZUmR-IW9pic7TOBNinWSyA>
X-ME-Proxy-Cause: dmFkZTFJ7RDuL5dRtxtmkk5SMosrItJAfwc4oWufk3SNc6DNr0MzPpyXFeOgDOj+SC+7VG
    gDLmdcIGAMEy6SvPVLwR38A8EYjj971zEN/qd49lsQrDDzn8eWCFTF95iK1+Ayhjk6th5V
    cDBGTDJGbrdbdSYt3UfnKI/gXe9H5O/0P1uKE+rxe3bi8TaGAEGDuVAUP6vYwe9+YhqYwj
    OGGF3miId6HKbWrZMpK3Hf9J69Lm6bIo1KuDJ0lb+P3dNdT6FGwDr7lclnzR0aHBhsrV63
    vJCddi5wXFWggnHNRcxD4AJa7oivP6OBG0aH6On2UXumY8nu03YmMmbsxnVqrSxyDZ9gB4
    o80/epZ2oayIgXsZpD0wSyUaBvSr+AKMD7BMY+zjUWRXOD2sisBN26oUvMv7eXjfR60vnv
    Ar/fAsdTW2xfQd8pnIV8xG8XCRrxQUOC74RWIgTjjagr7UeCac24X0IbCVN8y+A2s/2xEt
    egLCAMzNr4qWhlWd+7Xl24sy0eOo/KHuZ4zeyDGXcLggM4OXiS2ywzmtkMtneHWw4Hkfrw
    JbWWxsyrqDj94TPJC3h0JiikBtrxveEl98a7kytV+DxFBKcX3ndg/SZWdut1QMRjpujd41
    P2ZsbFeCFJt8kcK5NcOWfI90w8HPS90vQFibZfMHtFzk+GU7nEcByqQQjhGg
X-ME-Proxy: <xmx:yqLXagQccDo_S7ryEbLCaZWLxSyp662epkFvYvNhfSxe2-zKfX4m6A>
    <xmx:yqLXausD0CLxtJsei4gMROOrmLnpLaIPKXk2r11MuW2NBzvthf6FHg>
    <xmx:yqLXauLSZ_sFNy_EBVFYnavhbc10jMp6EnkqB0P3aKI4p7RLdE7lkQ>
    <xmx:yqLXaieghWR6EWicJsg5qVElq_xnlixX55C40nT5j87Brj7ubyAUIw>
    <xmx:yqLXagXdsQpqdX_nl0_rQ9KibsgmMPk7R2Y7x00Ta8QCLQd2ogVNkgig>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 2E82E19C0067; Tue, 20 Oct 2026 13:20:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 20:19:49 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Pavel E Popov" <pavel.e.popov@intel.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Logan Gunthorpe" <logang@deltatee.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Jim Chow" <jim.chow@broadcom.com>, "Radu Rugina" <radu.rugina@broadcom.com>,
 "Alexey Makhalov" <alexey.makhalov@broadcom.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Michael Kelley" <mhklinux@outlook.com>,
 "Nathan Ciobanu" <nathan.d.ciobanu@linux.intel.com>,
 "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
 virtualization@lists.linux.dev,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <25a0cdb4-9c4f-4531-bdf2-8d09eedd0883@app.fastmail.com>
In-Reply-To: <20261020163758.GA2342476@bhelgaas>
References: <20261020163758.GA2342476@bhelgaas>
Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Oct 20, 2026, at 19:37, Bjorn Helgaas wrote:
> On Tue, Oct 20, 2026 at 07:14:47PM +0300, Leon Romanovsky wrote:
>> On Tue, Oct 20, 2026 at 08:13:05AM -0700, Pavel Popov wrote:
>> > Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
>> > upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
>> > VMware guests, passthrough devices appear directly on virtual root
>> > buses without host bridge devices. In Hyper-V guests, each passthrough
>> > device appears in a PCI domain of its own without a host bridge
>> > device. Consequently, P2PDMA checks evaluate endpoint Device IDs
>> > against the host bridge whitelist, causing P2PDMA requests to fail
>> > regardless of host support.
>> > 
>> > This affects discrete devices such as GPUs, NICs and NVMe drives.
>> > 
>> > Add an explicit list of the Intel Xeon server generations from
>> > Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
>> > CPUs whose host bridges are in pci_p2pdma_whitelist[] without
>> > restrictions. AMD Zen and newer are already covered by
>> > cpu_supports_p2pdma(), so only Intel entries are needed.
>> > 
>> > Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
>> > cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
>> > 
>> > Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
>> > ---
>> > Changes in v3:
>> > - Drop the hypervisor check and move the Xeon list into
>> >   cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
>> >   Gunthorpe and Leon Romanovsky [1]
>> > - Fold the VMware and Hyper-V patches into one, as the check no longer
>> >   depends on the hypervisor
>> > 
>> > Changes in v2:
>> > - Replace the Skylake-and-newer threshold with an explicit list of Intel
>> >   Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
>> >   Gunthorpe)
>> > - Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
>> >   (Logan Gunthorpe)
>> > - Rebased on current mainline
>> > 
>> > [1] https://lore.kernel.org/r/20261016153147.GC219304@unreal
>> > 
>> > v2: https://lore.kernel.org/r/20261016223402.19991-1-pavel.e.popov@intel.com
>> > v1: https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel.com
>> > 
>> >  drivers/pci/p2pdma.c | 26 ++++++++++++++++++++++++++
>> >  1 file changed, 26 insertions(+)
>> > 
>> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> > index 9334eb314663..2650d605d87d 100644
>> > --- a/drivers/pci/p2pdma.c
>> > +++ b/drivers/pci/p2pdma.c
>> > @@ -21,6 +21,11 @@
>> >  #include <linux/seq_buf.h>
>> >  #include <linux/xarray.h>
>> >  
>> > +#ifdef CONFIG_X86
>> > +#include <asm/cpu_device_id.h>
>> > +#include <asm/intel-family.h>
>> > +#endif
>> > +
>> >  struct pci_p2pdma {
>> >  	struct gen_pool *pool;
>> >  	bool p2pmem_published;
>> > @@ -519,6 +524,23 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>> >  	seq_buf_printf(buf, "%s;", pci_name(pdev));
>> >  }
>> >  
>> > +#ifdef CONFIG_X86
>> 
>> Do we really need all these #ifdefs? I'm pretty sure they're not
>> needed for the includes.
>
> Apparently we do.  I experimentally removed them and cross-compiled
> for arm64:

I'm pretty sure that it's not how asm headers are expected to be consumed.
There are general asm stubs for code outside of arch. Probably general code shouldn't include ifdefs to access these includes.

Thanks 

>
>   drivers/pci/p2pdma.c:24:10: fatal error: asm/cpu_device_id.h: No such 
> file or directory
>      24 | #include <asm/cpu_device_id.h>
> 	|          ^~~~~~~~~~~~~~~~~~~~~
