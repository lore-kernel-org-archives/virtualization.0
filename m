From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Wed, 12 Sep 2012 15:43:11 +0930
Message-ID: <87bohbdb0o.fsf__10664.3379702748$1347431655$gmane$org@rustcorp.com.au>
References: <1346159043-16446-2-git-send-email-levinsasha928@gmail.com>
	<20120906084526.GE17656@redhat.com>
	<87txvahfv3.fsf@rustcorp.com.au>
	<14037987.hiN6MSGY6z@tomlt1.ibmoffice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <14037987.hiN6MSGY6z@tomlt1.ibmoffice.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Lendacky <tahm@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, avi@redhat.com, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Lendacky <tahm@linux.vnet.ibm.com> writes:
> I ran some TCP_RR and TCP_STREAM sessions, both host-to-guest and
> guest-to-host, with a form of the histogram patch applied against a
> RHEL6.3 kernel. The histogram values were reset after each test.

Hey, thanks!  This is exactly what I wanted to see...

> 60 session TCP_RR from host-to-guest with 256 byte request and 256 byte
> response for 60 seconds:
>
> Queue histogram for virtio1:
> Size distribution for input (max=7818456):
>  1: 7818456 ################################################################

These are always 1, so we don't indirect them anyway, so no cache required.

> Size distribution for output (max=7816698):
>  2: 149     
>  3: 7816698 ################################################################
>  4: 2       
>  5: 1       
> Size distribution for control (max=1):
>  0: 0

OK, tiny TCP data, but latency sensitive.

> Queue histogram for virtio1:
> Size distribution for input (max=16050941):
>  1: 16050941 ################################################################
> Size distribution for output (max=1877796):
>  2: 1877796 ################################################################
>  3: 5       
> Size distribution for control (max=1):
>  0: 0

Acks.  Not that many, not that latency sensitive.

> 4 session TCP_STREAM from guest-to-host with 4K message size for 60 seconds:
>
> Queue histogram for virtio1:
> Size distribution for input (max=1316069):
>  1: 1316069 ################################################################
> Size distribution for output (max=879213):
>  2: 24      
>  3: 24097   #
>  4: 23176   #
>  5: 3412    
>  6: 4446    
>  7: 4663    
>  8: 4195    
>  9: 3772    
> 10: 3388    
> 11: 3666    
> 12: 2885    
> 13: 2759    
> 14: 2997    
> 15: 3060    
> 16: 2651    
> 17: 2235    
> 18: 92721   ######  
> 19: 879213  ################################################################

Hey, that +1 is there in MAX_SKB_FRAGS for a reason!  Who knew?

This looks like we could really use a:

        int vq_set_indirect_cache(struct virtqueue *vq, unsigned num);

Which networking would set on the xmit queue(s) if we have GSO.

The real question is now whether we'd want a separate indirect cache for
the 3 case (so num above should be a bitmap?), or reuse the same one, or
not use it at all?

Benchmarking will tell...

Thanks,
Rusty.
