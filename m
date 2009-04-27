From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 27 Apr 2009 20:42:00 +0300
Message-ID: <20090427174200.GD2276__41433.6133668714$1240856757$gmane$org@redhat.com>
References: <20090427123136.GA1152@redhat.com> <49F5C38A.10806@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49F5C38A.10806@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2009 at 09:39:06AM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> Add optional MSI-X support: use a vector per virtqueue with
>> fallback to a common vector and finally to regular interrupt.
>> Teach all drivers to use it.
>>
>> I added 2 new virtio operations: request_vqs/free_vqs because MSI
>> needs to know the total number of vectors upfront.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>   
>
> Do you have userspace patches for testing?
>
> Regards,
>
> Anthony Liguori

Not ready yet, sorry.

-- 
MST
