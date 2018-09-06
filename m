From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 03/11] UAPI: virtio_net: Fix use of C++ keywords as
	structural members
Date: Thu, 06 Sep 2018 08:09:19 +0100
Message-ID: <9357.1536217759__49986.4670368426$1536217644$gmane$org@warthog.procyon.org.uk>
References: <20180905125636-mutt-send-email-mst@kernel.org>
	<153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
	<153616289529.23468.7498785670556620808.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180905125636-mutt-send-email-mst@kernel.org>
Content-ID: <9356.1536217759.1@warthog.procyon.org.uk>
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
Cc: linux-kbuild@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dhowells@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin <mst@redhat.com> wrote:

> As long as you do not intend to use any classes, how about
> simply adding
> 
> -Dclass=_class
> 
> to your command line?

That kind of misses the point;-).  It's not reasonable to expect all userspace
C++ users to do this.

David
