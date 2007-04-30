From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 04/12] i386 voyager: Use modern techniques to setup and
	teardown low identiy mappings.
Date: Mon, 30 Apr 2007 12:06:17 -0500
Message-ID: <1177952777.3674.41.camel__24008.020226802$1177952822$gmane$org@mulgrave.il.steeleye.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>
	<m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zm4p509a.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vefd4zyj.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1vefd4zyj.fsf_-_@ebiederm.dsl.xmission.com>
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
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-04-30 at 09:57 -0600, Eric W. Biederman wrote:
> This is a trivial and hopefully obviously correct patch to setup
> and teardown the identity mappings the way the rest of arch/i386
> does.
> 
> My new page table setup code will break some assumptions below so
> this is my attempt to keep voyager working. 

It works for the 586 beasts ... I'll dig out some 486 cards and test
them later.  Thanks,

James
