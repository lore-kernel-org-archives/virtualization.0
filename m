From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC REPOST 1/2] paravirt: refactor struct paravirt_ops
 into smaller pv_*_ops
Date: Mon, 15 Oct 2007 12:23:47 -0700
Message-ID: <4713BE43.50506@goop.org>
References: <470BC758.1030504@goop.org> <200710120001.52456.rusty@rustcorp.com.au> <470FC7F4.1030300@goop.org> <200710151816.36758.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763413AbXJOTYN@vger.kernel.org>
In-Reply-To: <200710151816.36758.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, "Nakajima, Jun" <jun.nakajima@intel.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Saturday 13 October 2007 05:16:04 Jeremy Fitzhardinge wrote:
>   
>> Are you otherwise happy with the patch in its current form?  And are you
>> happy with the lazymode changes?
>>     
>
> No, and yes.
>
> This applies on top of your 1/2.  Boots here, runs lguest.  It also 
> exports pv_info: lg.ko checks it to avoid lguest-in-lguest.
>   

Yeah, OK, I can live with that.  I'll fold it into the base patch, and
update the lazymode patch accordingly.

    J
