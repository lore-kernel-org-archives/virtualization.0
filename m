From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v13 1/5] Introduce xbitmap
Date: Mon, 07 Aug 2017 14:58:45 +0800
Message-ID: <59880FA5.6040703__10585.7153459967$1502089016$gmane$org@intel.com>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
	<1501742299-4369-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1501742299-4369-2-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, mawilcox@microsoft.com, akpm@linux-foundation.org, willy@infradead.org
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, liliang.opensource@gmail.com, amit.shah@redhat.com, pbonzini@redhat.com, cornelia.huck@de.ibm.com, quan.xu@aliyun.com, yang.zhang.wz@gmail.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 08/03/2017 02:38 PM, Wei Wang wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster.  It supports up to
> 'unsigned long' worth of bits, and this commit adds the bare bones --
> xb_set_bit(), xb_clear_bit() and xb_test_bit().
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   include/linux/radix-tree.h |   2 +
>   include/linux/xbitmap.h    |  49 ++++++++++++++++
>   lib/radix-tree.c           | 139 ++++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 188 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/xbitmap.h
>
> diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
> index 3e57350..428ccc9 100644
> --- a/include/linux/radix-tree.h
> +++ b/include/linux/radix-tree.h


Hi Matthew,

Could you please help to upstream this patch?


Best,
Wei
