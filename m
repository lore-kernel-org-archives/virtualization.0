From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: virtio-scsi spec (was Re: [PATCH] Add virtio-scsi to the virtio
	spec)
Date: Thu, 01 Dec 2011 09:49:20 +0100
Message-ID: <4ED73F90.5050603@redhat.com>
References: <1322661042-28191-1-git-send-email-pbonzini@redhat.com>
	<1322661042-28191-2-git-send-email-pbonzini@redhat.com>
	<4ED63AE1.8090105@suse.de> <4ED65BA4.3000003@redhat.com>
	<4ED74E54.3070303@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED74E54.3070303@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 12/01/2011 10:52 AM, Hannes Reinecke wrote:
>>>>
>>> I would like to have the other request_queue limitations exposed
>>> here, too.
>>> Most notably we're missing the maximum size of an individual segment
>>> and the maximum size of the overall I/O request.
>>
>> The virtio transport does not put any limit, as far as I know.
>>
> Virtio doesn't, but the underlying device/driver might.
> And if we don't expose these values we cannot format the request correctly.

These limits should be per target/LUN, so it seems like material for 
another controlq command when the need arises.  For now, I'd really 
prefer to have the spec match the implementation (plus a few SAM 
bogosities).

Paolo
