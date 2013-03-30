From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Sat, 30 Mar 2013 13:49:00 +1030
Message-ID: <878v554lsr.fsf@rustcorp.com.au>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
	<87wqt0du2e.fsf@rustcorp.com.au>
	<20130324201910.GA31631@redhat.com>
	<8738vjer43.fsf@rustcorp.com.au>
	<20130326193911.GA19251@redhat.com>
	<87ip4d4sef.fsf@rustcorp.com.au>
	<20130327112535.GE24243@redhat.com> <5153CC2E.3090908@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5153CC2E.3090908@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> On 03/27/2013 04:25 AM, Michael S. Tsirkin wrote:
>> 
>> Aha. Yes, good idea.  As for how large the offsets are,
>> I am guessing we should either just say offset is vqn * X and data is
>> vqn, or give hypervisors full flexibility with 32 bit offset and
>> arbitrary data.
>> 16 bit offsets seem neither here nor there ...
>
> Shift count?

You can only have 2^16 vqs per device.  Is it verboten to write 16-bit
values to odd offsets?  If so, we've just dropped it to 2^15 before you
have to do some decoding to do.  Hard to care...

I dislike saying "multiply offset by 2" because implementations will get
it wrong.  That's because 0 will work either way, and that's going to be
the common case.

Cheers,
Rusty.
