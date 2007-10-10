From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch 32/43] lguest: Virtio interface
Date: Wed, 10 Oct 2007 10:50:48 +0200
Message-ID: <200710101050.49012.borntraeger@de.ibm.com>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063650.895058914@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070926063650.895058914@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

I have a late question :-)

> There is also a generic implementation of config space which drivers can query
> to get setup information from the host.

After thinking about that for a while, is there a special reason the config
field is defined as little endian? The only reason I can come up with, is to
use virtio for cross platform emulators, lets say a ppc emulates an x86 system
with virtio devices instead of real ones.

Do you have other reasons for a fixed endianess?

Christian
