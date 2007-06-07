From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Wed, 06 Jun 2007 17:08:54 -0700
Message-ID: <46674C96.7090104__28681.4324711033$1181175015$gmane$org@zytor.com>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org>
	<4667462A.2010404@zytor.com> <466749C8.2010700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466749C8.2010700@goop.org>
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
> I'm not sure I fully understand the mechanism you're proposing.  You
> have the 16-bit setup code, the 32-bit decompressor, and an ELF.gz. Once
> the decompressor has extracted the actual ELF file, are you proposing
> that it properly parse the ELF file and follow its instuctions to put
> the segments in the appropriate places, or are you assuming that the
> decompressor can just skip that part and plonk the ELF file where it wants?
> 
> In other words, do you see the Phdrs as being descriptive or prescriptive?
> 

I was thinking prescriptive, having the decompressor read the output
stream and interpret it as ELF.  I guess a descriptive approach could be
made to work, too (I haven't really thought about that avenue of
approach), but the prescriptive model seems more powerful, at least to me.

	-hpa
