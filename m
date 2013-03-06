From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/6] virtio_ring: inline internal vring functions more
	aggressively.
Date: Thu, 07 Mar 2013 10:02:17 +1100
Message-ID: <87ehfs9lom.fsf@rustcorp.com.au>
References: <87k3plaz3d.fsf@rustcorp.com.au> <87a9qhayri.fsf@rustcorp.com.au>
	<20130306102412.GC16921@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130306102412.GC16921@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Mar 06, 2013 at 04:22:09PM +1100, Rusty Russell wrote:
>> We use inline and get gcc to do the right thing inlining the
>> "indirect" traversal functions.  This also means we don't need to
>> clean the sgs.
>> 
>> for i in `seq 50`; do /usr/bin/time -f 'Wall time:%e' ./vringh_test --indirect --eventidx --parallel --fast-vringh; done 2>&1 | stats --trim-outliers:
>> 
>> Before:
>> 	Using CPUS 0 and 3
>> 	Guest: notified 0, pinged 39014-39063(39062)
>> 	Host: notified 39014-39063(39062), pinged 0
>> 	Wall time:1.900000-2.350000(1.921875)
>> 
>> After:
>> 	Using CPUS 0 and 3
>> 	Guest: notified 0, pinged 39062-39063(39063)
>> 	Host: notified 39062-39063(39063), pinged 0
>> 	Wall time:1.760000-2.220000(1.789167)
>> 
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> 
>
> It's pretty cool that gcc is able to optimize it like this.
> Which gcc version did you use here?

Gcc has done this for quite a while now... I reported a bug about it in
2008: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=35728

This was i686-linux-gnu-gcc-4.7 (Ubuntu/Linaro 4.7.2-2ubuntu1) 4.7.2.

Cheers,
Rusty.
