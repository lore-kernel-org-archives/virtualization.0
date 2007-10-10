From: "Eric Van Hensbergen" <ericvh@gmail.com>
Subject: Re: [patch 32/43] lguest: Virtio interface
Date: Wed, 10 Oct 2007 10:31:07 -0500
Message-ID: <a4e6962a0710100831r309f266nc901f7c81ebef478@mail.gmail.com>
References: <20070926063618.956228976@rustcorp.com.au>
	<200710101050.49012.borntraeger@de.ibm.com>
	<5d6222a80710100643w7b02b3a7oa24a076b2bad4f52@mail.gmail.com>
	<200710101624.04531.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710101624.04531.arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/10/07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Since virtio is a rather generic concept, there are other things you
> might want to do with them, like routing virtio data over the network
> to a machine with different endianess, or actually building hardware
> that implements some sort of virtio compatible interface.
>

That being the case, why not just use network byte order (big endian)?

        -eric
