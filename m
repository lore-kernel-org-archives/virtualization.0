From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 3/8] s390/cio: add basic protected virtualization
	support
Date: Wed, 29 May 2019 14:30:47 +0200
Message-ID: <20190529143047.35b5c7d3.cohuck@redhat.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
	<20190523162209.9543-4-mimu@linux.ibm.com>
	<20190527123802.54cd3589.cohuck@redhat.com>
	<20190527143014.3b48a0d2.pasic@linux.ibm.com>
	<20190527153130.0f473ffd.cohuck@redhat.com>
	<e794bad2-5fc2-b30c-972e-b586770a0065@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e794bad2-5fc2-b30c-972e-b586770a0065@linux.ibm.com>
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
Cc: Vasily Gorbik <gor@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 29 May 2019 14:24:39 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> On 27.05.19 15:31, Cornelia Huck wrote:

> > To actually make the guest use the 3270 as its console, I guess you
> > need to explicitly force it (see
> > https://wiki.qemu.org/Features/3270#Using_3270_as_the_console)...
> > actually starting the console will almost certainly fail; but you can
> > at least check whether device recognition in the console path works.
> >   
> >>
> >> Mimu, do we have something more elaborate with regards to this?  
> 
> I ran that with success
> 
> [root@ap01 ~]# lscss | grep 3270
> 0.0.002a 0.0.0008  0000/00 3270/00 yes  80  80  ff   01000000 00000000
> 
> and was able to connect and login.

Oh, cool. I'm actually a bit surprised this works without additional
changes to the 3270 code :)
