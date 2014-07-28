From: Amit Shah <amit.shah@redhat.com>
Subject: Re: When I boot two virtio-rng devices, guest will hang
Date: Mon, 28 Jul 2014 14:42:13 +0530
Message-ID: <20140728091213.GC3797@grmbl.mre>
References: <20140728073242.GD2683@z.redhat.com>
	<20140728075514.GB3797@grmbl.mre>
	<20140728084920.GF2683@z.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140728084920.GF2683@z.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, kvm@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 28 Jul 2014 [16:49:20], Amos Kong wrote:
> On Mon, Jul 28, 2014 at 01:25:14PM +0530, Amit Shah wrote:
> > On (Mon) 28 Jul 2014 [15:32:42], Amos Kong wrote:
> > > QEMU commandline:
> > > 
> > > ./x86_64-softmmu/qemu-system-x86_64 --enable-kvm   -m 2000 -drive file=/images/nolvm.qcow2 --kernel /home/devel/linux/arch/x86/boot/bzImage -append "ro root=/dev/sda1 console=ttyS0,115200"  -monitor unix:/tmp/m,nowait,server -device virtio-net-pci,netdev=h0,vectors=17,mq=on,id=n0 -netdev tap,id=h0,queues=8 -device virtio-net-pci,netdev=h1,vectors=0,mq=on,id=n1 -netdev tap,id=h1,queues=8  -vnc :0 -mon chardev=qmp,mode=control,pretty=on -chardev socket,id=qmp,host=localhost,port=1234,server,nowait -serial stdio -object rng-random,filename=/dev/urandom,id=rng0   -device virtio-rng-pci,rng=rng0,id=h0 -object rng-random,filename=/dev/urandom,id=rng1   -device virtio-rng-pci,rng=rng1,id=h1
> > > 
> > > It works when I only add one virtio-rng device. Did you touch this
> > > problem?
> > > 
> > > I'm using latest net-next/master (ac3d2e5a9ef2f4d8f57c50070c4883ecb7cec29f)
>  
> Hi Amit,
> 
> > <snip>
> > > [    0.223503] Non-volatile memory driver v1.3
> > > [    1.172293] tsc: Refined TSC clocksource calibration: 2893.436 MHz
> > > qemu: terminating on signal 2           <---------- (I have to cancel QEMU process by Ctrl + C)
> > 
> > This looks similar to what I saw when driver asks for randomness from the host
> > before probe is completed.
> > 
> > Does the following patch help?
> 
> This patch was already inclued in latest net-next/master
> patch commit: e052dbf554610e2104c5a7518c4d8374bed701bb

No, it's a different one, goes on top of the commit you referenced.

		Amit
