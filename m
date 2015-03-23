From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] virtio_mmio: fix endian-ness for mmio
Date: Mon, 23 Mar 2015 11:49:25 +0000
Message-ID: <1427111365.3726.22.camel@arm.com>
References: <1425592060-18474-1-git-send-email-mst@redhat.com>
	<871tkvx98n.fsf@rustcorp.com.au>
	<20150312081047-mutt-send-email-mst@redhat.com>
	<878uf1wv1a.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <878uf1wv1a.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2015-03-13 at 01:22 +0000, Rusty Russell wrote:
> I'm sure Pawel is on a beach somewhere sipping cocktails, 

Ehm... There's still a some more prohibition for me (granted, by choice,
just to share the "pain" ;-), so it wasn't exactly 

> so I'll apply
> this immediately (with your updated commit message) to my
> pending-rebases and give him the weekend to Ack.

Not that it matters any more, but a belated

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks, Michael, for fixing this! (although, I must admit, I haven't
tested it yet - all in right time :-)

Pawel
