From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: fix thinko in multiport documentation
Date: Fri, 14 Dec 2012 11:31:21 +1030
Message-ID: <8762454fby.fsf@rustcorp.com.au>
References: <20120909110837.GA2395@redhat.com>
	<20121212082224.GA3827@redhat.com>
	<20121212091420.GB21936@amit.redhat.com>
	<20121212092341.GC4354@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121212092341.GC4354@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Dec 12, 2012 at 02:44:20PM +0530, Amit Shah wrote:
>> On (Wed) 12 Dec 2012 [10:22:24], Michael S. Tsirkin wrote:
>> > On Sun, Sep 09, 2012 at 02:08:37PM +0300, Michael S. Tsirkin wrote:
>> > > spec numbers ports port0, port 1 etc, then goes on to say
>> > > "ports 2 onwards only if MULTIPORT is set".
>> > > An obvious thinko, should be port 1 onwards.
>> > > 
>> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > 
>> > Rusty, Amit, any feedback?
>> 
>> http://thread.gmane.org/gmane.linux.kernel.virtualization/16973/focus=16980
>> 
>> 		Amit
>
> Ah you acked.
> Rusty can you pick this up please?

Thanks, done.

Cheers,
Rusty.
