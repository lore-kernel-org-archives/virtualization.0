From: john cooper <john.cooper@redhat.com>
Subject: Re: [PATCH 1/4] virtio_blk: deprecate the 1024-byte ID field.
Date: Mon, 05 Oct 2009 12:20:12 -0400
Message-ID: <4ACA1CBC.8020402__32475.6958907985$1254762734$gmane$org@redhat.com>
References: <200909300248.09630.rusty@rustcorp.com.au>
	<200909300941.24736.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200909300941.24736.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: john.cooper@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Am Dienstag 29 September 2009 19:18:09 schrieb Rusty Russell:
>> PCI, lguest and s390 can all only support 256-byte configuration
>> space.  So, this giant field broke just about everyone.
>> Unfortunately, removing it is not so simple: we don't want to break
>> old userspace, but we're going to want to re-use that part of the
>> struct.
>>
>> So, modern users can #define VIRTIO_BLK_IDENTIFY_DEPRECATED to indicate
>> that they know it's no longer in the config struct, and can use any
>> new features (all new features which add a configuration field will
>> conflict with this deprecated one).
> 
> 
> Since s390 never used the giant id field, it would be ok for us just delete it 
> (without the #define). IIRC kvm-userspace also never used that. Since qemu 
> upstream seems to use that field your way seems to be the only compatible...

It seems simply retiring use of the VIRTIO_BLK_F_IDENTIFY
binary value should be sufficient.  The patch which
implemented the cooperating logic in qemu was dropped
due to the config space issue.  So the case of a virtio_blk
driver successfully negotiating the feature and trying to
access the now depreciated structure area should effectively
be a non-issue.  The bit value can be reclaimed for reuse
in the future when concern over any suspected usage falls
into the noise.

-john

-- 
john.cooper@redhat.com
