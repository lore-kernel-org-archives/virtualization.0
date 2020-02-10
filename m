From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Date: Mon, 10 Feb 2020 12:01:56 +0100
Message-ID: <43a5dbaa-9129-e220-8483-45c60a82c945@de.ibm.com>
References: <20200107042401-mutt-send-email-mst@kernel.org>
 <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
 <20200107065434-mutt-send-email-mst@kernel.org>
 <fe6e7e90-3004-eb7a-9ed8-b53a7667959f@de.ibm.com>
 <20200120012724-mutt-send-email-mst@kernel.org>
 <2a63b15f-8cf5-5868-550c-42e2cfd92c60@de.ibm.com>
 <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
 <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
 <20200206171349-mutt-send-email-mst@kernel.org>
 <5c860fa1-cef5-b389-4ebf-99a62afa0fe8@de.ibm.com>
 <20200207025806-mutt-send-email-mst@kernel.org>
 <97c93d38-ef07-e321-d133-18483d54c0c0@de.ibm.com>
 <CAJaqyWfngzP4d01B6+Sqt8FXN6jX7kGegjx8ie4no_1Er3igQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAJaqyWfngzP4d01B6+Sqt8FXN6jX7kGegjx8ie4no_1Er3igQA@mail.gmail.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 10.02.20 10:47, Eugenio Perez Martin wrote:
> Hi Christian.
> 
> I'm not able to reproduce the failure with eccb852f1fe6bede630e2e4f1a121a81e34354ab commit. Could you add more data? Your configuration (libvirt or qemu line), and host's dmesg output if any?
> 
> Thanks!

If it was not obvious, this is on s390x, a big endian system.
