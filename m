From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 32/43] lguest: Virtio interface
Date: Wed, 10 Oct 2007 18:00:07 +0200
Message-ID: <200710101800.08317.arnd@arndb.de>
References: <20070926063618.956228976@rustcorp.com.au>
	<200710101624.04531.arnd@arndb.de>
	<a4e6962a0710100831r309f266nc901f7c81ebef478@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a4e6962a0710100831r309f266nc901f7c81ebef478@mail.gmail.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 10 October 2007, Eric Van Hensbergen wrote:
> That being the case, why not just use network byte order (big endian)?

PCI hardware is by convention little-endian, so I'd vote for that, but
it doesn't really matter as long as it's fixed endian.

The advantage of big-endian would be that it's not what x86 uses, so
endianess bugs are more likely to hit early.

	Arnd <><
