From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VIRTIO adoption in other hypervisors
Date: Fri, 28 Feb 2020 11:58:29 +0100
Message-ID: <fca8366e-662f-af2f-382c-0216d9df63f8@redhat.com>
References: <87mu93vwy2.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-6815-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <87mu93vwy2.fsf@linaro.org>
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: jan.kiszka@siemens.com, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>
List-Id: virtualization@lists.linuxfoundation.org

On 28/02/20 11:16, Alex Benn=C3=A9e wrote:
>   - How about HyperV and the OSX equivalent?

OS X Hypervisor.framework just uses QEMU, so it can use virtio devices
too.  VirtualBox also supports virtio devices.

Paolo
