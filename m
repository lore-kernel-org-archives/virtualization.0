From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v3 2/3] virtio-balloon: improve update_balloon_size_func
Date: Tue, 15 Jan 2019 10:18:59 +0800
Message-ID: <5C3D4313.7090306__18280.3657757633$1547691896$gmane$org@intel.com>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
	<1546844466-38079-3-git-send-email-wei.w.wang@intel.com>
	<20190114195450-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190114195450-mutt-send-email-mst@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 01/15/2019 09:00 AM, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 03:01:05PM +0800, Wei Wang wrote:
>> There is no need to update the balloon actual register when there is no
>> ballooning request. This patch avoids update_balloon_size when diff is 0.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> It sounds reasonable but it does have a side effect of
> not writing into actual anymore.
>
> I am not sure actual never can get out of sync as a result.
>
> So better deferred, pls send this in the next merge window.
>

No problem, it's not urgent to me.

Best,
Wei
