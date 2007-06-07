From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Thu, 07 Jun 2007 09:14:50 -0700
Message-ID: <46682EFA.1020406@zytor.com>
References: <20070606225837.654272428@goop.org>
	<200706062147.21225.rob@landley.net> <46676552.4060308@zytor.com>
	<200706071208.04777.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200706071208.04777.rob@landley.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Landley <rob@landley.net>
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Rob Landley wrote:
> 
> Er, make that objcopy, not objdump.
> 
> Sane, maybe not.  Something people want to do (and under the mistaken 
> assumption I know more about initramfs then they do, have asked me how), yes.  
> It always boils down to "do you have a vmlinux image lying around?  Doing 
> this with a bzImage _is_ brain surgery", and has yet to get beyond that 
> question.  I had about half of a script worked out for this, once...
> 

If it can be done today on a vmlinux then it can be done the same way
with the mechanism I have proposed.  Period, full stop.

> You can also supply an external initramfs image through the initrd mechanism, 
> but this is unpleasant to do with some bootloaders (or lack of bootloaders).  
> Plus it doesn't remove the old one, and wasting space makes embedded 
> developers itch.

In thory one could create an extended bzImage format which could handle
a concatenated, and easily replaceable, initrd, but if it's done on
vmlinux today it would make a *lot* more sense to have it be done on the
vmlinux and nothing else.

	-hpa
