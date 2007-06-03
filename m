From: Avi Kivity <avi@qumranet.com>
Subject: Re: [Xen-devel] Re: [kvm-devel] [PATCH RFC 1/3] virtio
	infrastructure
Date: Sun, 03 Jun 2007 14:39:22 +0300
Message-ID: <4662A86A.7010706__39039.4320631914$1180870824$gmane$org@qumranet.com>
References: <1180613947.11133.58.camel@localhost.localdomain>	<46610E8D.10706@qumranet.com>	<1180777836.9228.44.camel@localhost.localdomain>	<46625192.5020108@qumranet.com>
	<1180866540.17442.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180866540.17442.74.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Hmm... Perhaps I should move the used arrays into the "struct
> virtio_device" and guarantee that the id (returned by add_*buf) is an
> index into that.  Then we can trivially add a corresponding bit array.
>
>   

That may force the virtio backend to do things it doesn't want to.

> This also makes the "id" easier to use from the driver side: if we add a
> "max_id" field it can size its own arrays if it wants to.  Gets rid of
> the linked-list in the block driver...
>   

How about

    struct virtio_completion {
        unsigned long length;
        void *data;
    };

    int virtio_complete(struct virtio_completion *completions, int nr);


where 'data' is an opaque pointer passed by the device during add_*buf()?

-- 
error compiling committee.c: too many arguments to function
