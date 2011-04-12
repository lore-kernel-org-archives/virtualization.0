From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC][PATCH] virtio: 64 bit features
Date: Tue, 12 Apr 2011 12:55:42 +0930
Message-ID: <87ei58cfrd.fsf__43498.3359453783$1302580250$gmane$org@rustcorp.com.au>
References: <20110411165525.GA1395@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110411165525.GA1395@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefs>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 11 Apr 2011 19:55:25 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Extend features to 64 bit so we can use more
> transport bits.
> 
> Future patches add two new feature bits which would
> exhaust the supply of transport feature bits,
> so let's add bit 31 to tell the guest that
> there are now 64 worth of features.
> 
> For PCI this also changes the config layout.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This was pretty much the way I imagined it would work.  We need a patch
to the spec and a lot of cross testing...

Thanks!
Rusty.
