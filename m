From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v3 0/8] vhost: Reset batched descriptors on SET_VRING_BASE call
Date: Wed, 1 Apr 2020 20:40:25 +0200
Message-ID: <CAJaqyWc+fNzHE_p-pApZtj2ypNQfFLawCWf8GJmP8e=k=C+EgA@mail.gmail.com>
References: <20200331192804.6019-1-eperezma@redhat.com> <c4d2b0b4-0b6d-cd74-0eb5-e7fdfe063d42@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4d2b0b4-0b6d-cd74-0eb5-e7fdfe063d42@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 1, 2020 at 9:19 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> On 31.03.20 21:27, Eugenio P=C3=A9rez wrote:
> > Vhost did not reset properly the batched descriptors on SET_VRING_BASE
> > event. Because of that, is possible to return an invalid descriptor to
> > the guest.
> >
> > This series ammend this, resetting them every time backend changes, and
> > creates a test to assert correct behavior. To do that, they need to
> > expose a new function in virtio_ring, virtqueue_reset_free_head, only
> > on test code.
> >
> > Another useful thing would be to check if mutex is properly get in
> > vq private_data accessors. Not sure if mutex debug code allow that,
> > similar to C++ unique lock::owns_lock. Not acquiring in the function
> > because caller code holds the mutex in order to perform more actions.
>
>
>
> >
> > v3:
> > * Rename accesors functions.
> > * Make scsi and test use the accesors too.
> >
> > v2:
> > * Squashed commits.
> > * Create vq private_data accesors (mst).
> >
> > This is meant to be applied on top of
> > c4f1c41a6094582903c75c0dcfacb453c959d457 in
> > git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
>
>
> A quick test on s390 looks good.
>

Really good to know :).

Would it be possible to investigate when qemu launches the offending ioctls=
?

Thanks!
