From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] percpu ida: Switch to cpumask_t, add some comments
Date: Wed, 28 Aug 2013 13:25:50 -0700
Message-ID: <20130828132550.d0ce4d3a4d40ee07e7e8a1c1@linux-foundation.org>
References: <1376694549-20609-1-git-send-email-nab@linux-iscsi.org>
	<1376694549-20609-2-git-send-email-nab@linux-iscsi.org>
	<20130820143157.f91bf59d16352989b54e431e@linux-foundation.org>
	<20130828195517.GF8032@kmo-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130828195517.GF8032@kmo-pixel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kent Overstreet <kmo@daterainc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andi Kleen <andi@firstfloor.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, lkml <linux-kernel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 28 Aug 2013 12:55:17 -0700 Kent Overstreet <kmo@daterainc.com> wrote:

> Fixup patch, addressing Andrew's review feedback:

Looks reasonable.

>  lib/idr.c           | 38 +++++++++++++++++++++-----------------

I still don't think it should be in this file.

You say that some as-yet-unmerged patches will tie the new code into
the old ida code.  But will it do it in a manner which requires that
the two reside in the same file?
