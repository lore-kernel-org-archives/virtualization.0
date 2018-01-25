From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v24 2/2] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Thu, 25 Jan 2018 17:45:19 +0800
Message-ID: <5A69A72F.4000104__35891.8125661605$1516873285$gmane$org@intel.com>
References: <1516790562-37889-1-git-send-email-wei.w.wang@intel.com>
	<1516790562-37889-3-git-send-email-wei.w.wang@intel.com>
	<20180124183349-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180124183349-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/25/2018 01:15 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 24, 2018 at 06:42:42PM +0800, Wei Wang wrote:
>>   
>>
>> What is this doing? Basically handling the case where vq is broken?
>> It's kind of ugly to tweak feature bits, most code assumes they never
>> change.  Please just return an error to caller instead and handle it
>> there.
>>
>> You can then avoid sprinking the check for the feature bit
>> all over the code.
>>
>
> One thing I don't like about this one is that the previous request
> will still try to run to completion.
>
> And it all seems pretty complex.
>
> How about:
> - pass cmd id to a queued work
> - queued work gets that cmd id, stores a copy and uses that,
>    re-checking periodically - stop if cmd id changes:
>    will replace  report_free_page too since that's set to
>    stop.
>
> This means you do not reuse the queued cmd id also
> for the buffer - which is probably for the best.

Thanks for the suggestion. Please have a check how it's implemented in v25.
Just a little reminder that work queue has internally ensured that there 
is no re-entrant of the same queued function.

Best,
Wei
