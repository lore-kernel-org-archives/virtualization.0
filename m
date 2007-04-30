From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 05/12] i386: During page table initialization always set
 the leaf page table entries.
Date: Mon, 30 Apr 2007 09:34:14 -0700
Message-ID: <46361A86.70408__30629.8013696962$1177950876$gmane$org@goop.org>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>	<m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com>	<m1zm4p509a.fsf_-_@ebiederm.dsl.xmission.com>	<m1vefd4zyj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r6q14zow.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1r6q14zow.fsf_-_@ebiederm.dsl.xmission.com>
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

Eric W. Biederman wrote:
> If we don't set the leaf page table entries it is quite possible that
> will inherit and incorrect page table entry from the initial boot
> page table setup in head.S.  So we need to redo the effort here,
> so we pick up PSE, PGE and the like.
>
> Hypervisors like Xen require that their page tables be read-only,
> which is slightly incompatible with our low identity mappings, however
> I discussed this with Jeremy he has modified the Xen early set_pte
> function to avoid problems in this area.
>
> Andi I sent this once a part of the discussion on this issue so
> you may already have this patch in your queue.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>   

Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>

    J
