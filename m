From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v29 3/4] mm/page_poison: expose page_poisoning_enabled
	to kernel modules
Date: Mon, 26 Mar 2018 14:24:00 -0700
Message-ID: <20180326142400.82c7f29992c4b0c3a8f4d230__20204.4175043286$1522099342$gmane$org@linux-foundation.org>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
	<1522031994-7246-4-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1522031994-7246-4-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, mst@redhat.com, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, huangzhichao@huawei.com, pbonzini@redhat.com, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 26 Mar 2018 10:39:53 +0800 Wei Wang <wei.w.wang@intel.com> wrote:

> In some usages, e.g. virtio-balloon, a kernel module needs to know if
> page poisoning is in use. This patch exposes the page_poisoning_enabled
> function to kernel modules.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
