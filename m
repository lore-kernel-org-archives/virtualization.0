From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH] mm: don't zero ballooned pages
Date: Mon, 31 Jul 2017 16:34:58 +0800
Message-ID: <597EEBB2.8080609__40756.1592678123$1501489941$gmane$org@intel.com>
References: <1501474413-21580-1-git-send-email-wei.w.wang@intel.com>
	<20170731065508.GE13036@dhcp22.suse.cz>
	<597EDF3D.8020101@intel.com>
	<20170731074350.GC15767@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170731074350.GC15767@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: mst@redhat.com, mawilcox@microsoft.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, zhenwei.pi@youruncloud.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/31/2017 03:43 PM, Michal Hocko wrote:
> On Mon 31-07-17 15:41:49, Wei Wang wrote:
>> On 07/31/2017 02:55 PM, Michal Hocko wrote:
>>> On Mon 31-07-17 12:13:33, Wei Wang wrote:
>>>> Ballooned pages will be marked as MADV_DONTNEED by the hypervisor and
>>>> shouldn't be given to the host ksmd to scan.
>>> Could you point me where this MADV_DONTNEED is done, please?
>> Sure. It's done in the hypervisor when the balloon pages are received.
>>
>> Please see line 40 at
>> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c
> Thanks. Are all hypervisors which are using this API doing this?


The implementation may be different across different hypervisors.
But the underlying concept is the same - they unmap the balloon
pages from the guest and those pages will be given to other guests
or host processes to use.

Regardless of the implementation, I think it is an improper operation
to make the memory KSM mergeable when the memory does not
belong to the guest anymore.


Best,
Wei
