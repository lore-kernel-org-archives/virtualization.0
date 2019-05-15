From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 10/10] virtio/s390: make airq summary indicators DMA
Date: Wed, 15 May 2019 19:18:51 +0200
Message-ID: <20190515191851.79f230ae.pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-11-pasic@linux.ibm.com>
	<20190513142010.36c8478f.cohuck@redhat.com>
	<3a8353e2-97e3-778e-ab2e-ef285ac7027d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3a8353e2-97e3-778e-ab2e-ef285ac7027d@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Mueller <mimu@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 15 May 2019 15:43:23 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> > Hm, where is airq_areas_lock defined? If it was introduced in one of
> > the previous patches, I have missed it.  
> 
> There is no airq_areas_lock defined currently. My assumption is that
> this will be used in context with the likely race condition this
> part of the patch is talking about.

Right! I first started resolving the race, but then decided to discuss
the issue first, because if I were to just have hallucinated that race,
it would be a lots of wasted effort. Unfortunately I forgot to get rid
of this comment.

Regards,
Halil
