From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Date: Mon, 20 Jan 2020 10:06:10 +0100 (CET)
Message-ID: <20200120.100610.546818167633238909.davem@davemloft.net>
References: <20200116172428.311437-1-sgarzare@redhat.com>
        <20200116172428.311437-2-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116172428.311437-2-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhansen@vmware.com, jasowang@redhat.com, kvm@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, mst@redhat.com, decui@microsoft.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 16 Jan 2020 18:24:26 +0100

> This patch adds 'netns' module param to enable this new feature
> (disabled by default), because it changes vsock's behavior with
> network namespaces and could break existing applications.

Sorry, no.

I wonder if you can even design a legitimate, reasonable, use case
where these netns changes could break things.

I am totally against adding a module parameter for this, it's
incredibly confusing for users and will create a test scenerio
that is strongly less likely to be covered.
