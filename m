From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 07/10] s390/airq: use DMA memory for adapter interrupts
Date: Thu, 9 May 2019 13:37:01 +0200
Message-ID: <20190509133701.3e93299b.cohuck@redhat.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-8-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190426183245.37939-8-pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 26 Apr 2019 20:32:42 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Protected virtualization guests have to use shared pages for airq
> notifier bit vectors, because hypervisor needs to write these bits.
> 
> Let us make sure we allocate DMA memory for the notifier bit vectors.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/include/asm/airq.h |  2 ++
>  drivers/s390/cio/airq.c      | 18 ++++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)

As an aside, there are some other devices that use adapter interrupts
as well (pci, ap, qdio). How does that interact with their needs? Do
they continue to work on non-protected virt guests (kvm or z/VM), and
can they be accommodated if support for them on protected guests is
added in the future?

(For some of the indicator bit handling, I suspect millicode takes care
of it anyway, but at least for pci, there's some hypervisor action to
be aware of.)

Also, as another aside, has this been tested with a regular guest under
tcg as well? If not, can you provide a branch for quick verification
somewhere?
