From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] VSOCK: Split vm_sockets.h into kernel/uapi
Date: Thu, 07 Mar 2013 16:58:10 +0000
Message-ID: <26621.1362675490__23278.8541856737$1362675583$gmane$org@warthog.procyon.org.uk>
References: <1362669973-26984-1-git-send-email-acking@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362669973-26984-1-git-send-email-acking@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy King <acking@vmware.com>
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dhowells@redhat.com, gregkh@linuxfoundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Andy King <acking@vmware.com> wrote:

> Split the vSockets header into kernel and UAPI parts.  The former gets the bits
> that used to be in __KERNEL__ guards, while the latter gets everything that is
> user-visible.  Tested by compiling vsock (+transport) and a simple user-mode
> vSockets application.
> 
> Reported-by: David Howells <dhowells@redhat.com>
> Acked-by: Dmitry Torokhov <dtor@vmware.com>
> Signed-off-by: Andy King <acking@vmware.com>

Acked-by: David Howells <dhowells@redhat.com>
