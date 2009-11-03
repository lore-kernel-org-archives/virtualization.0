From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv4 1/6] qemu/virtio: move features to an inline function
Date: Tue, 3 Nov 2009 12:40:55 +0200
Message-ID: <20091103104055.GA3375__21824.3455900394$1257245181$gmane$org@redhat.com>
References: <cover.1257200517.git.mst@redhat.com>
	<20091102222329.GB15153@redhat.com> <4AEF5E51.80101@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AEF5E51.80101@codemonkey.ws>
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

On Mon, Nov 02, 2009 at 04:33:53PM -0600, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> devices should have the final say over which virtio features they
>> support. E.g. indirect entries may or may not make sense in the context
>> of virtio-console. In particular, for vhost, we do not want to report to
>> guest bits not supported by kernel backend.  Move the common bits from
>> virtio-pci to an inline function and let each device call it.
>>
>> No functional changes.
>>   
>
> This is a layering violation.  There are transport specific features and  
> device specific features.  The virtio-net device should have no  
> knowledge or nack'ing ability for transport features.

We could pass "vhost" flag to virtio, and have virtio query the device
for features. Would that be better?

> If you need to change transport features, it suggests you're modeling  
> things incorrectly and should be supplying an alternative transport  
> implementation.
> Regards,
>
> Anthony Liguori

Yes, you can make vhost an alternative transport in qemu.  This might be
one way to handle this. However, this seems to go contrary to your
previous proposal to make vhost a networking back end. Which will it be?

-- 
MST
