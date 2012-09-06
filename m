From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: Fix kconfig option
Date: Thu, 06 Sep 2012 11:16:46 +0930
Message-ID: <87mx13j52x.fsf@rustcorp.com.au>
References: <20120903044133.GA9980@moria.home.lan>
	<87wr0ae26e.fsf@rustcorp.com.au> <20120905061219.GC7517@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120905061219.GC7517@redhat.com>
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
Cc: Kent Overstreet <koverstreet@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Tue, Sep 04, 2012 at 03:53:53PM +0930, Rusty Russell wrote:
>> Kent Overstreet <koverstreet@google.com> writes:
>> 
>> > CONFIG_VIRTIO isn't exposed, everything else is supposed to select it
>> > instead.
>> 
>> This is a slight mis-understanding.  It's supposed to be selected by
>> the particular driver, probably virtio_pci in your case.
>> 
>> Cheers,
>> Rusty.
>
> Actually balloon selects VIRTIO, I think it's a bug.
> Also isn't it time we dropped the experimental tag?
> Leaving it in for now.

Thanks, I applied this, and killed the EXPERIMENTAL in a separate patch.

Cheers,
Rusty.
