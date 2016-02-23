From: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 2/2] virtio_balloon: export 'available' memory to balloon
	statistics
Date: Tue, 23 Feb 2016 18:26:47 +0300
Message-ID: <56CC7A37.2030807__40618.5617823668$1456241930$gmane$org@openvz.org>
References: <1455637852-7323-1-git-send-email-den@openvz.org>
	<1455637852-7323-3-git-send-email-den@openvz.org>
	<20160223170828-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160223170828-mutt-send-email-mst@redhat.com>
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
Cc: Igor Redko <redkoi@virtuozzo.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/23/2016 06:10 PM, Michael S. Tsirkin wrote:
> On Tue, Feb 16, 2016 at 06:50:52PM +0300, Denis V. Lunev wrote:
>> From: Igor Redko <redkoi@virtuozzo.com>
>>
>> Add a new field, VIRTIO_BALLOON_S_AVAIL, to virtio_balloon memory
>> statistics protocol, corresponding to 'Available' in /proc/meminfo.
>>
>> It indicates to the hypervisor how big the balloon can be inflated
>> without pushing the guest system to swap.
>>
>> Signed-off-by: Igor Redko <redkoi@virtuozzo.com>
>> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
> Oops - I missed the fact that this affects host/guest ABI.
>
> Can you please submit ABI update proposal to virtio tc?
> Spec patch would be even better.
>
> This is important to ensure there are no conflicts
> with other features being developed in parallel.

hmmm

 From my point of view ABI remains untouched.
The guest can send any amount of <tag>;<value>
pairs and unknown tags are properly ignored
by the host.

That is why I think that this change is safe.
