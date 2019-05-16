From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 06/10] s390/cio: add basic protected virtualization support
Date: Thu, 16 May 2019 08:32:28 +0200
Message-ID: <20190516083228.0cc5b489.cohuck@redhat.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-7-pasic@linux.ibm.com>
	<20190513114136.783c851c.cohuck@redhat.com>
	<d0ffefec-a14e-ee83-0aae-df288c3ffda4@linux.ibm.com>
	<20190515230817.2f8a8a5d.pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190515230817.2f8a8a5d.pasic@linux.ibm.com>
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 15 May 2019 23:08:17 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 14 May 2019 10:47:34 -0400
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> > Are we 
> > worried that virtio data structures are going to be a burden on the 31-bit address space?
> > 
> >   
> 
> That is a good question I can not answer. Since it is currently at least
> a page per queue (because we use dma direct, right Mimu?), I am concerned
> about this.
> 
> Connie, what is your opinion?

Yes, running into problems there was one of my motivations for my
question. I guess it depends on the number of devices and how many
queues they use. The problem is that it affects not only protected virt
guests, but all guests.
