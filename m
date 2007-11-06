From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio config_ops refactoring
Date: Wed, 7 Nov 2007 09:57:43 +1100
Message-ID: <200711070957.44165.rusty__13109.5125260346$1194390035$gmane$org@rustcorp.com.au>
References: <4730A8F3.6020008@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4730A8F3.6020008@us.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Dor Laor <dor.laor@qumranet.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 07 November 2007 04:48:35 Anthony Liguori wrote:
> Semantically, find requires that a field have both a type and a length.
> With the exception of the VIRTQUEUE field used internally by lguest,
> type is always a unique identifier.  Since virtqueue information is not
> a required part of the config space, it seems to me that type really
> should be treated as a unique identifier.

Hi Anthony,

	Not sure I get this.  It is a unique identifier.  You need the length
to handle unknown fields.

> find_vq also is curious in that it is stateful in it's enumeration.

Well, they're *all* stateful.  This gives a simple method of knowing what 
fields the guest understands: it marks the fields as it finds them.  Then it 
sets the status, which allows the host to know when it's completed 
configuration reads.

I like enumerating the virtqueues: it's not necessary but it's clearer.

> This adds seemingly unnecessary complexity.

I'd be happy for a simpler mechanism...

Cheers,
Rusty.
