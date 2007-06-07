From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Wed, 06 Jun 2007 17:20:56 -0700
Message-ID: <46674F68.6030100__47399.7339410291$1181175750$gmane$org@goop.org>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org>
	<4667462A.2010404@zytor.com> <466749C8.2010700@goop.org>
	<46674C96.7090104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46674C96.7090104@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> I was thinking prescriptive, having the decompressor read the output
> stream and interpret it as ELF.  I guess a descriptive approach could be
> made to work, too (I haven't really thought about that avenue of
> approach), but the prescriptive model seems more powerful, at least to me.

Certainly, but much harder to implement.  The ELF parser needs to be
prepared to move itself around to get out of the way of the ELF file. 
It's a fairly large change from how it works now.

I was thinking of making the ELF file entirely descriptive, since its
just a set of ELF headers inserted into the existing bzImage structure,
and it still relies on the bzImage being build properly in the first place.

    J
