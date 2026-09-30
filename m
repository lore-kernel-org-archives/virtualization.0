Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793643B8BBF;
	Wed, 30 Sep 2026 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749164; cv=pass; b=Wb/MGI+8rtQQc6EI3yFZYHj7hmAxtzzXaWT1Ho2/uBajDuZbqbnShiz9Uet6TIAtsQWAnkuemk+PiPCnb7okqmSw8SiFwzRyh4if5OEgZR1tb6J4fPTo2XWuZ2/TfQ8CLlFDgRa1zeeQyGHUolT5SKZbEAaoND82SOvyAKfk1h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749164; c=relaxed/simple;
	bh=zFoTYb73ldMKwmEbO428TD3BtZYTxTeL01meO4CkLck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNeiVnGh7GCh/6NkTbjlICmxp0AWFBjbnUVzVYSO5zjhFoJvtwV391I1gyD/pb5yzWcTvJPTwRoigdKNl/omAel4qGEe72FON9Yc8MNECGg/cTzCYzt8Ov5W0YJglU/z6PnUpUBsfUvCM8uN7u4/VMxLp82xl3xKWIcz8eOWqC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=kZSrusab; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=vNWaZTSM; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="kZSrusab";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="vNWaZTSM"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-kr49.prod.antispam.mailspamprotection.com; s=arckey; t=1790749162;
	 b=iDIhjD5f4n1aKHTSDHb2PIRdiX27rHYZRhLCzBEe4Wuw/mirMIOVxAJ8v+glq+dgfzaohapmRc
	  hAEgjbNs+qVXMQbOHbmqAdJyBGqQfqIJxe7SysjKE3nYV8U8uAJvE8hchGv/nwVEztb16CunWj
	  FCCkc9NxUO7M8L3egfHcTfg+edY8KajS65vSiOkbNntCV0Y70z4Z6rghAGm4U2S6AsXQkFLBQR
	  /merw5ROacY6KLeh/n7rQ0r2AAEC8Ro9u4hmHNBc5HxA0TZ1c4zeQBPpYpzMjx4xAiJgzmy2ZA
	  ziQ28o/eQMZNb/S6OENmMJfZPGt3c0uYow+tcN8Piave+Q==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-kr49.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-kr49.prod.antispam.mailspamprotection.com; s=arckey; t=1790749162;
	bh=zFoTYb73ldMKwmEbO428TD3BtZYTxTeL01meO4CkLck=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=1BOTpyvUPijcdxHh9te/Oay/m9Bm24F2aV78fK8EY5y6iVxB97gzeIbo1wlzKW4gPzqNgcZO5f
	  mckaH3Ey/kRZTkgvSspa1D7WNj29ufp+IpMsz875GgiBHVcse0uc1dqTmqg8aE/6RYXL61p/5t
	  yKW0eFaXE4vC7CH//Gf4J4ethOkpvwzyiENE5JkUbL0d6SNPWDWPHRu84Foty08PqmeR59Krah
	  azXp3zkOpdE/pv/cHG3S31iUJDPzAeA/S9aHKAWVu202gC9RahFT2I67Xwvh+tQXeB/+0pU1hN
	  a2rOvfcoHRL9HPTJ9fNoixLv5+XIDd7tgqhPenfSH89TYg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=AbLTFjIhx+uI0756kXzx+0Wed7ebu42odZefl23u124=; b=kZSrusab/QZIiCLVOpmjc2TsLT
	0sqbamHWLyEE4NaQhyIeGwZ5L94+aQc14Q6IPSSn5KhFD7+TYZ0E6iEDLphnxl6kn70K17Y1OELQL
	A974K74x773b9mvjAJH1zMSVfAm+cV8I/1yYuyPFfmJ0Eil+0ZeH5EcdmQN/pVeupZ+U=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-kr49.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBnes-00000000DDm-39hf;
	Wed, 30 Sep 2026 06:19:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=AbLTFjIhx+uI0756kXzx+0Wed7ebu42odZefl23u124=; b=vNWaZTSMdKSjuGWs4B1nAJLk+v
	JgZgpuuMYwkOKAokZdtW4FbhvcKdbSfQAbmDZuPhMmsifXY+It3LX1H5Tlom/t/67KuTCjwJ5VbNj
	f7iaIxoAD//wZICuPL52kUW9hdtchJiO7XOsr74gbRyS39at1urOoT9laQIF81sUJWDo=;
Received: from [87.14.44.235] (port=64978 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBneo-00000000PI1-2Ld3;
	Wed, 30 Sep 2026 06:19:10 +0000
Date: Wed, 30 Sep 2026 08:19:08 +0200
From: Francesco Valla <francesco@valla.it>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
	Eugenio Perez <eperezma@redhat.com>, robh@kernel.org, conor+dt@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: add bindings for spi-virtio
Message-ID: <arypmHeudsJm4RIN@bywater>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
 <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>
 <20260929165015.E5DDF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929165015.E5DDF1F000FF@smtp.kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: ad6de6e4cc0feb0ba0f106e4f1151177
X-AntiAbuse: ID - ad6de6e4cc0feb0ba0f106e4f1151177
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBnes-00000000DDm-39hf-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-kr49.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Tue, Sep 29, 2026 at 04:50:14PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dt-bindings: spi-virtio: undocumented compatible in example
> --
> 
> commit eb6ae8a9a8b3aa403347f70589897a8c7d297186
> Author: Francesco Valla <francesco@valla.it>
> 
> dt-bindings: spi: add bindings for spi-virtio
> 
> This commit adds device tree bindings for spi-virtio based on virtio-device.
> It defines the properties and node dependencies for the virtio SPI controller.
> 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
> > new file mode 100644
> > index 0000000000000..5b8639dd2e1f1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
> 
> [ ... ]
> 
> > +examples:
> > +  - |
> > +    virtio@3000 {
> > +        compatible = "virtio,mmio";
> > +        reg = <0x3000 0x100>;
> > +        interrupts = <41>;
> > +
> > +        spi {
> > +            compatible = "virtio,device2d";
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            sram@0 {
> > +                compatible = "microchip,mchp23k256";
> 
> [Severity: Low]
> Is this compatible string documented in any existing binding schema?
>

Yes - the compatible fot the Microchip MCHP23K256 is documented in:

  Documentation/devicetree/bindings/mtd/microchip,mchp23k256.yaml

> The dt_binding_check tool strictly validates all compatible strings against
> known schemas, so an undocumented compatible string in an example will emit a
> schema validation warning.
> 
> When running make dt_binding_check on the new spi-virtio.yaml file, it
> parses the example and attempts to match microchip,mchp23k256 against
> registered bindings, which fails if none exist.
> 
> > +                reg = <0>;
> > +                spi-max-frequency = <20000000>;
> > +            };
> > +        };
> > +    };
> > +
> > +...
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it?part=1
