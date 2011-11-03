From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio-pci new configuration proposal
Date: Thu, 3 Nov 2011 13:03:39 +0200
Message-ID: <20111103110339.GB18296@redhat.com>
References: <1320259767.22582.2.camel@lappy> <8762j2t19l.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8762j2t19l.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <anthony@codemonkey.ws>, virtualization <virtualization@lists.linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, kvm <kvm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 03, 2011 at 12:28:46PM +1030, Rusty Russell wrote:
> 3) If we're changing the queue layout, it's a chance to fix a
>    longstanding bug: let the guest notify the host of preferred
>    queue size and alignment.

With device config split from the common one, we can
just tuck new fields at the tail of the common one.

-- 
MST
