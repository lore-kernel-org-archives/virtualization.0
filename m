From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Sun, 24 Sep 2006 18:07:26 -0700
Message-ID: <45172BCE.4010708@goop.org>
References: <1158925861.26261.3.camel@localhost.localdomain>
	<1158925997.26261.6.camel@localhost.localdomain>
	<1158926106.26261.8.camel@localhost.localdomain>
	<1158926215.26261.11.camel@localhost.localdomain>
	<1158926308.26261.14.camel@localhost.localdomain>
	<1158926386.26261.17.camel@localhost.localdomain>
	<4514663E.5050707@goop.org> <20060923081337.GA10534@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060923081337.GA10534@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> I managed to get all this done in head.S before going into C code; is =

>> that not still possible?  Or is there a later patch to do this.
>>     =

>
> Why write in assembler what you can write in C?
>   =

This stuff is very basic, and you could consider it as being part of the =

kernel's C runtime model, and therefore can be expected to be available =

everywhere.  In particular, the use of current is so prevalent that you =

really can't call anything without having the PDA set up.

    J
