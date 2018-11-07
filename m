From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Wed, 7 Nov 2018 14:18:58 +0800
Message-ID: <8963dba5-c2fb-69d0-4adb-72d751a9dedf__25701.2774855413$1541571422$gmane$org@redhat.com>
References: <5BDFF537.3050806@huawei.com>
	<485c2c5d-d73e-e679-9549-aad3de02f0ab@redhat.com>
	<5BE134EF.1070009@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5BE134EF.1070009@huawei.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>, stefanha@redhat.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvNiDkuIvljYgyOjMwLCBqaWFuZ3lpd2VuIHdyb3RlOgo+PiBTZWVtcyBkdXBs
aWNhdGVkIHdpdGggdGhlIG9uZSB1c2VkIGJ5IHZob3N0LW5ldC4KPj4KPj4gSW4gcGFja2VkIHZp
cnRxdWV1ZSBpbXBsZW1lbnRhdGlvbiwgSSBwbGFuIHRvIG1vdmUgdGhpcyB0byB2aG9zdC5jLgo+
Pgo+IFllcywgdGhpcyBjb2RlIGlzIGZ1bGwgY29waWVkIGZyb20gdmhvc3QtbmV0LCBpZiBpdCBj
YW4gYmUgcGFja2VkIGludG8KPiB2aG9zdC5jLCBpdCB3b3VsZCBiZSBncmVhdC4KPgoKSWYgeW91
IHRyeSB0byByZXVzZSB2aG9zdC1uZXQsIHlvdSBkb24ndCBldmVuIG5lZWQgdG8gY2FyZSBhYm91
dCB0aGlzIDopCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
