From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 03/10] define ELF notes for adding to a boot image
Date: Tue, 26 Jun 2007 16:21:37 -0400
Message-ID: <46817551.9040800__45512.6713881784$1182889403$gmane$org@goop.org>
References: <20070615004818.424726597@goop.org>	<20070615005012.882738673@goop.org>	<4672BC5B.1040502@zytor.com>	<4672C0FF.9080209@goop.org>
	<20070626131830.9a4d4ae6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070626131830.9a4d4ae6.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Xen-Devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> Jeremy, I'll duck these patches for now, sorry.  Mainly on
> i-already-have-enough-x86-stuff grounds.
>   

That's fine.  I think it breaks x86-64 at the moment anyway.  And I 
haven't got much feedback about it.

> There's a bit of overlap between this work and git-newsetup, but nothing
> particularly serious-looking.
>   

Yes, I based it on the newsetup stuff in -mm, so there shouldn't be too 
much difference.

    J
