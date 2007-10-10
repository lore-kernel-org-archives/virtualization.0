From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC REPOST 1/2] paravirt: refactor struct paravirt_ops
 into smaller pv_*_ops
Date: Wed, 10 Oct 2007 10:48:56 -0700
Message-ID: <470D1088.1030908@goop.org>
References: <470BC758.1030504@goop.org> <200710101635.10139.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756292AbXJJRtv@vger.kernel.org>
In-Reply-To: <200710101635.10139.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, "Nakajima, Jun" <jun.nakajima@intel.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>> +	OFFSET(PARAVIRT_enabled, pv_info, paravirt_enabled);
>>     
>
> I think this gives the right answer for the wrong reasons?
>   

Actually, it was OK.  The only use is in entry.S, which uses pv_info +
PARAVIRT_enabled.

    J
