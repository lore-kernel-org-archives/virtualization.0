From: Jason Wang <jasowang@redhat.com>
Subject: Re: INFO: task hung in vhost_init_device_iotlb
Date: Tue, 2 Jul 2019 15:23:01 +0800
Message-ID: <0d542a30-7122-aea7-07fe-b49dedcd9daf__16241.365081963$1562052239$gmane$org@redhat.com>
References: <0000000000007e86fd058095533f@google.com>
	<20190129105957-mutt-send-email-mst@kernel.org>
	<CACT4Y+Yiz2NpDMNLSP+Z-qf9Swo56Yhb0CbmrUyPHojmMZzCAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACT4Y+Yiz2NpDMNLSP+Z-qf9Swo56Yhb0CbmrUyPHojmMZzCAQ@mail.gmail.com>
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
To: Dmitry Vyukov <dvyukov@google.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, syzbot <syzbot+40e28a8bd59d10ed0c42@syzkaller.appspotmail.com>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMS8zMCDkuIvljYg0OjEyLCBEbWl0cnkgVnl1a292IHdyb3RlOgo+IE9uIFR1ZSwg
SmFuIDI5LCAyMDE5IGF0IDU6MDYgUE0gTWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRoYXQuY29t
PiAgd3JvdGU6Cj4+IE9uIFR1ZSwgSmFuIDI5LCAyMDE5IGF0IDAxOjIyOjAyQU0gLTA4MDAsIHN5
emJvdCB3cm90ZToKPj4+IEhlbGxvLAo+Pj4KPj4+IHN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5n
IGNyYXNoIG9uOgo+Pj4KPj4+IEhFQUQgY29tbWl0OiAgICA5ODM1NDI0MzRlNmIgTWVyZ2UgdGFn
ICdlZGFjX2ZpeF9mb3JfNS4wJyBvZiBnaXQ6Ly9naXQua2VyLi4KPj4+IGdpdCB0cmVlOiAgICAg
ICB1cHN0cmVhbQo+Pj4gY29uc29sZSBvdXRwdXQ6aHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20veC9sb2cudHh0P3g9MTc0NzY0OThjMDAwMDAKPj4+IGtlcm5lbCBjb25maWc6aHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29uZmlnP3g9NTA1NzQzZWJhNGU0ZjY4Cj4+PiBkYXNo
Ym9hcmQgbGluazpodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9NDBlMjhh
OGJkNTlkMTBlZDBjNDIKPj4+IGNvbXBpbGVyOiAgICAgICBnY2MgKEdDQykgOS4wLjAgMjAxODEy
MzEgKGV4cGVyaW1lbnRhbCkKPj4+Cj4+PiBVbmZvcnR1bmF0ZWx5LCBJIGRvbid0IGhhdmUgYW55
IHJlcHJvZHVjZXIgZm9yIHRoaXMgY3Jhc2ggeWV0Lgo+PiBIbW0gbm90aGluZyBvYnZpb3VzIGJl
bG93LiBHZW5lcmljIGNvcnJ1cHRpb24gZWxzZXdoZXJlPwo+IEhhcmQgdG8gc2F5LCBhIHNpbGVu
dCBtZW1vcnkgY29ycnVwdGlvbiBpcyBkZWZpbml0ZWx5IHBvc3NpYmxlLgo+IElmIHRoZXJlIGlz
IG5vdGhpbmcgb2J2aW91cyBsZXQncyB3YWl0LCBtYXliZSBzeXpib3Qgd2lsbCBjb21lIHVwIHdp
dGgKPiBhIHJlcHJvIG9yIHdlIGdldCBtb3JlIHN1Y2ggaGFuZ3Mgc28gdGhhdCBpdCB3aWxsIGJl
IHBvc3NpYmxlIHRvIHJ1bGUKPiBvdXQgZmxha2VzL2NvcnJ1cHRpb25zLgo+CgpJdCBoYXNuJ3Qg
YmVlbiByZXByb2R1Y2VkIGZvciBhIHdoaWxlLiBXZSBjYW4gaW52YWxpZCB0aGlzIGFuZCBzZWUg
aWYgd2UgCmNhbiBnZXQgaXQgYWdhaW4uCgpTbwoKI3N5eiBpbnZhbGlkCgpUaGFua3MKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
