From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 08/12] i386: Convert the boot time page tables to the
	kernels native format.
Date: Mon, 30 Apr 2007 10:42:31 -0600
Message-ID: <m1odl53jbc.fsf@ebiederm.dsl.xmission.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
	<m1irbd4zcm.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ejm14z5f.fsf_-_@ebiederm.dsl.xmission.com>
	<200704301826.57920.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704301826.57920.ak@suse.de> (Andi Kleen's message of "Mon, 30
	Apr 2007 18:26:57 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen <ak@suse.de> writes:

> On Monday 30 April 2007 18:15:08 Eric W. Biederman wrote:
>> 
>> Currently we have a lot of special case code and a lot of limitations
>> because we cannot count on the initial boot time page tables being in
>> the format our page table handling routines know how to manipulate.
>> So this patch rewrites the code that initializes our boot time page
>> tables.
>
> Sounds reasonable, but for post .22

Sure.  A little aging to gain confidence with it is reasonable.  At
this point I finally have the glitches worked out so these patches
needed to get out of my private queue.

Eric
