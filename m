From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VIRTIO adoption in other hypervisors
Date: Fri, 28 Feb 2020 12:21:35 +0100
Message-ID: <71f1773d-579d-fec9-cd49-e500bbca1bc4@redhat.com>
References: <87mu93vwy2.fsf@linaro.org>
 <fca8366e-662f-af2f-382c-0216d9df63f8@redhat.com> <87k147vu29.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-6819-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <87k147vu29.fsf@linaro.org>
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: virtualization@lists.linux-foundation.org, jan.kiszka@siemens.com, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On 28/02/20 12:18, Alex Benn=C3=A9e wrote:
>> OS X Hypervisor.framework just uses QEMU, so it can use virtio devices
>> too.  VirtualBox also supports virtio devices.
> I guess these don't do any sort of vhost support so all virtio devices
> are handled directly in QEMU?

OS X can use vhost-user.

Paolo
