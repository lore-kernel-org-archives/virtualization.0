From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 08/12] i386: Convert the boot time page tables to the
	kernels native format.
Date: Mon, 30 Apr 2007 18:26:57 +0200
Message-ID: <200704301826.57920.ak__15283.321720972$1177950616$gmane$org@suse.de>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
	<m1irbd4zcm.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ejm14z5f.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1ejm14z5f.fsf_-_@ebiederm.dsl.xmission.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 30 April 2007 18:15:08 Eric W. Biederman wrote:
> 
> Currently we have a lot of special case code and a lot of limitations
> because we cannot count on the initial boot time page tables being in
> the format our page table handling routines know how to manipulate.
> So this patch rewrites the code that initializes our boot time page
> tables.

Sounds reasonable, but for post .22

-Andi
