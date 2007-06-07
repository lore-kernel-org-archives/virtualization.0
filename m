From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Wed, 06 Jun 2007 17:42:35 -0700
Message-ID: <4667547B.8080502__45829.1040421047$1181177024$gmane$org@zytor.com>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org>
	<4667462A.2010404@zytor.com> <466749C8.2010700@goop.org>
	<46674C96.7090104@zytor.com> <46674F68.6030100@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46674F68.6030100@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> 
> Certainly, but much harder to implement.  The ELF parser needs to be
> prepared to move itself around to get out of the way of the ELF file. 
> It's a fairly large change from how it works now.
> 

It doesn't if we simply declare that a certain chunk of memory is
available to it, for the case where it runs in the native configuration.
Since it doesn't have to support *any* ELF file, just the kernel one,
that's an option.

On the other hand, I guess with the decompressor/ELF parser being PIC,
one would simply look for the highest used address, and relocate itself
above that point.  It's not really all that different from what the
decompressor does today, except that it knows the address a priori.

> I was thinking of making the ELF file entirely descriptive, since its
> just a set of ELF headers inserted into the existing bzImage structure,
> and it still relies on the bzImage being build properly in the first place.

Again, it's an option.  The downside is that you don't get the automatic
test coverage of having it be exercised as often as possible.

	-hpa
